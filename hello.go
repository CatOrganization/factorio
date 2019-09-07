package main

import (
    "context"
    "fmt"

    "github.com/aws/aws-lambda-go/lambda"
)

type MyEvent struct {
    Name string `json:"name"`
}

func HandleRequest(ctx context.Context, name MyEvent) {
    fmt.Printf("Hello %s!", name.Name)
}

func main() {
    lambda.Start(HandleRequest)
}