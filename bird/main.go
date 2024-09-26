package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"math/rand"
	"net/http"
	"net/url"
	"time"
)

type Bird struct {
	Name        string
	Description string
	Image       string
}

// Function to return a default bird in case of errors
func defaultBird(err error) Bird {
	return Bird{
		Name:        "Bird in disguise",
		Description: fmt.Sprintf("This bird is in disguise because: %s", err),
		Image:       "https://www.pokemonmillennium.net/wp-content/uploads/2015/11/missingno.png",
	}
}

// Function to get bird image by bird name
func getBirdImage(birdName string) (string, error) {
	res, err := http.Get(fmt.Sprintf("http://localhost:4200?birdName=%s", url.QueryEscape(birdName)))
	if err != nil {
		return "", err
	}
	defer res.Body.Close() // Ensure body is closed after reading

	body, err := io.ReadAll(res.Body)
	if err != nil {
		return "", err
	}
	return string(body), nil
}

// Function to fetch bird factoid from API
func getBirdFactoid() Bird {
	res, err := http.Get(fmt.Sprintf("%s%d", "https://freetestapi.com/api/v1/birds/", rand.Intn(50)))
	if err != nil {
		fmt.Printf("Error reading bird API: %s\n", err)
		return defaultBird(err)
	}
	defer res.Body.Close() // Ensure body is closed after reading

	body, err := io.ReadAll(res.Body)
	if err != nil {
		fmt.Printf("Error parsing bird API response: %s\n", err)
		return defaultBird(err)
	}

	var bird Bird
	err = json.Unmarshal(body, &bird)
	if err != nil {
		fmt.Printf("Error unmarshalling bird: %s\n", err)
		return defaultBird(err)
	}

	// Fetch bird image
	birdImage, err := getBirdImage(bird.Name)
	if err != nil {
		fmt.Printf("Error in getting bird image: %s\n", err)
		return defaultBird(err)
	}
	bird.Image = birdImage
	return bird
}

// HTTP handler for bird factoid endpoint
func bird(w http.ResponseWriter, r *http.Request) {
	var buffer bytes.Buffer
	err := json.NewEncoder(&buffer).Encode(getBirdFactoid())
	if err != nil {
		http.Error(w, "Failed to encode bird factoid", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(buffer.Bytes())
}

// HTTP handler for health check endpoint
func healthCheck(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("ok"))
}

func main() {
	// Seed the random generator
	rand.Seed(time.Now().UnixNano())

	// Define HTTP handlers
	http.HandleFunc("/", bird)
	http.HandleFunc("/healthz", healthCheck)

	// Start the HTTP server
	fmt.Println("Server is starting on port 4201...")
	http.ListenAndServe(":4201", nil)
}
