# Shopify Image Repository API

## Introduction

The shopify image repository is an api that allows users to upload/delete images. The users have the option of uploading/deleting images in individually or in bulk. Users can only delete images that belongs to them. This API has 6 endpoints. Postman was used to call the api. 

## Table of Contents
1. [Local Setup](#local-setup)
1. [Endpoints](#endpoints)
    - [POST create_user](#post-create-user)
    - [POST authenticate](#post-authenticate)
    - [POST one_image](#post-one-image)
    - [POST bulk_images](#post-bulk-images)
    - [DELETE one_image](#delete-one-image)
    - [DELETE bulk_images](#delete-bulk-images)
1. [Storage](#storage)
1. [Testing](#testing)
1. [Versions](#versions)

## Local Setup
Use the following steps to run the app locally: 
* `git clone git@github.com:Miguel-Enrique13/Shopify-Image-Repository-API`
* `bundle install`
* `rails db:create`
* `rails db:migrate`
* `rails db:seed`
* `rails s`

## Endpoints

### POST create_user

You must first create a user before uploading any image.

parameters: 

| Keys  |  Requirement | Type  |
|---|---|---|
|`email`|`required`|`string`|
|`password`|`required`|`string`|
|`password_confirmation`|`required`|`string`|

Sample Request: localhost:3000/api/v1/create_user?email=example@email.com&password=password&password_confirmation=password

<details>
  <summary> Sample Response: </summary>
  
  ```
  {
    "message": "User created successfully"
}
```
</details>

## POST authenticate

Once a user is created, you can call this endpoint to create an AuthToken specific to your user. This AuthToken will be important for calling future endpoints.

parameters: 

| Keys  |  Requirement | Type  |
|---|---|---|
|`email`|`required`|`string`|
|`password`|`required`|`string`|

Sample Request: localhost:3000/api/v1/authenticate?email=example@email.com&password=password


<details>
  <summary> Sample Response: </summary>
  
  ```
  {
     "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2MTEwMTIzNDh9.ESAybXEYVyiUkPM4hbDsD-ZUuVGd4GErkoTVUwCGpkw"
}
```
</details>

## POST bulk_images

With this endpoint, a user can upload multiple images. To succesfully upload the images, the user must provide their `AuthToken` as string value with `Authorization` as the key in the headers section.    

headers:

| Keys  |  Requirement | Type  |
|---|---|---|
|`Authorization`|`Required`|`string`|

**POSTMAN** Body -> Form-data: 

| Keys  |  Requirement | Type  |
|---|---|---|
|`image_files[]`|`required`|`files`|

Sample Request: localhost:3000/api/v1/bulk_images

<details>
  <summary> Sample Response: </summary>
  
  ```
{
    "data": [
        {
            "id": "1",
            "type": "image",
            "attributes": {
                "id": 1,
                "title": "---",
                "description": "---",
                "price": 0.0,
                "privacy": "private",
                "inventory": 0
            },
            "relationships": {
                "user": {
                    "data": {
                        "id": "1",
                        "type": "user"
                    }
                }
            }
        },
        {
            "id": "2",
            "type": "image",
            "attributes": {
                "id": 2,
                "title": "---",
                "description": "---",
                "price": 0.0,
                "privacy": "private",
                "inventory": 0
            },
            "relationships": {
                "user": {
                    "data": {
                        "id": "1",
                        "type": "user"
                    }
                }
            }
        }
    ]
}
```
</details>

## POST one_image
With this endpoint, a user can upload one image. To succesfully upload the image, the user must provide their `AuthToken` as string value with `Authorization` as the key in the headers section.

headers:

| Keys  |  Requirement | Type  |
|---|---|---|
|`Authorization`|`Required`|`string`|

**POSTMAN** Body -> Form-data: 

| Keys  |  Requirement | Type  |
|---|---|---|
|`image_file`|`required`|`string`|
|`title`|`required`|`string`|
|`description`|`required`|`string`|
|`price`|`required`|`float`|
|`invetory`|`required`|`integer`|
|`privacy`|`required`|`string`|

Sample Request: localhost:3000/api/v1/one_image

<details>
  <summary> Sample Response: </summary>
  
  ```
{
    "data": {
        "id": "3",
        "type": "image",
        "attributes": {
            "id": 3,
            "title": "Image title",
            "description": "Image description",
            "price": 1.0,
            "privacy": "private",
            "inventory": 6
        },
        "relationships": {
            "user": {
                "data": {
                    "id": "1",
                    "type": "user"
                }
            }
        }
    }
}
```
</details>

## DELETE bulk_images

With this endpoint, a user can delete multiple image. To succesfully delete the images, the user must provide their `AuthToken` as string value with `Authorization` as the key in the headers section.

headers:

| Keys  |  Requirement | Type  |
|---|---|---|
|`Authorization`|`Required`|`string`|

**POSTMAN** Body -> Form-data: 

| Keys  |  Requirement | Type  |
|---|---|---|
|`image_id[]`|`required`|`integers separated by comma`|

Sample Request: localhost:3000/api/v1/bulk_images

<details>
  <summary> Sample Response: </summary>
  
  ```
{
    "message": "All authorized images have been deleted"
}
```
</details>

## DELETE one_image


With this endpoint, a user can delete one image. To succesfully delete the image, the user must provide their `AuthToken` as string value with `Authorization` as the key in the headers section.

headers:

| Keys  |  Requirement | Type  |
|---|---|---|
|`Authorization`|`Required`|`string`|

**POSTMAN** Body -> Form-data: 

| Keys  |  Requirement | Type  |
|---|---|---|
|`image_id`|`required`|`integer`|

Sample Request: localhost:3000/api/v1/one_image

<details>
  <summary> Sample Response: </summary>
  
  ```
{
    "message": "Image deleted"
}
```
</details>

## Storage
Your local disk will serve as the storage. Although typically a cloud service would be used for storage, for this occasion local storage works.

## Testing
All endpoint happy paths were tested. With more time, I would've also tested the sad paths. 

## Versions

![](https://img.shields.io/badge/Rails-5.2.4.3-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)













  
