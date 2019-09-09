package main

import (
	"log"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	awsSession "github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ec2"
)

var (
	accessKeyID = os.Getenv("AWS_ACCESS_KEY_ID")
	secretKey   = os.Getenv("AWS_SECRET_KEY")
)

func main() {
	if accessKeyID == "" || secretKey == "" {
		log.Print("Missing keys")
		os.Exit(1)
	}

	config := aws.NewConfig().
		WithRegion("us-east-2").
		WithCredentials(credentials.NewStaticCredentials(accessKeyID, secretKey, ""))
	session, err := awsSession.NewSession(config)
	if err != nil {
		log.Printf("Couldnt make session; err: %s", err)
		os.Exit(1)
	}

	ec2Service := ec2.New(session)
	println(ec2Service)
}
