#!/bin/bash

docker pull postgres

docker run --name postgres -e POSTGRES_PASSWORD=996311  -p 5432:5432 -d postgres 
