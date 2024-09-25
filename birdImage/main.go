package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
)

type Urls struct {
	Thumb string `json:"thumb"`
}

type Links struct {
	Urls Urls `json:"urls"`
}

type ImageResponse struct {
	Results []Links `json:"results"`
}

type Bird struct {
	Image string
}

// Default image URL in case of errors or no results
func defaultImage() string {
	return "https://www.pokemonmillennium.net/wp-content/uploads/2015/11/missingno.png"
}

// Function to get bird image using Unsplash API
func getBirdImage(birdName string) string {
	query := fmt.Sprintf(
		"https://api.unsplash.com/search/photos?page=1&query=%s&client_id=P1p3WPuRfpi7BdnG8xOrGKrRSvU1Puxc1aueUWeQVAI&per_page=1",
		url.QueryEscape(birdName),
	)
	res, err := http.Get(query)
	if err != nil {
		fmt.Printf("Error reading image API: %s\n", err)
		return defaultImage()
	}
	defer res.Body.Close() // Ensure the body is closed after reading

	body, err := io.ReadAll(res.Body)
	if err != nil {
		fmt.Printf("Error parsing image API response: %s\n", err)
		return defaultImage()
	}

	var response ImageResponse
	err = json.Unmarshal(body, &response)
	if err != nil {
		fmt.Printf("Error unmarshalling bird image: %s\n", err)
		return defaultImage()
	}

	// Check if the result contains any images
	if len(response.Results) == 0 {
		fmt.Println("No images found for the bird")
		return defaultImage()
	}

	return response.Results[0].Urls.Thumb
}

// Handler for fetching bird image
func bird(w http.ResponseWriter, r *http.Request) {
	var buffer bytes.Buffer
	birdName := r.URL.Query().Get("birdName")
	if birdName == "" {
		json.NewEncoder(&buffer).Encode(defaultImage())
	} else {
		json.NewEncoder(&buffer).Encode(getBirdImage(birdName))
	}
	w.Header().Set("Content-Type", "application/json")
	io.WriteString(w, buffer.String())
}

// Health check handler
func healthCheck(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("ok")) // Removed the incorrect `=`
}

func main() {
	http.HandleFunc("/", bird)
	http.HandleFunc("/healthz", healthCheck)
	fmt.Println("Server running on port 4200...")
	http.ListenAndServe(":4200", nil)
}
