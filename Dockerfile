FROM golang:1.15-alpine3.12 AS gobuilder-stage

WORKDIR /usr/src/goapp
COPY hello.go .

RUN CGO_ENABLE=0 GOOS=linux DOARCH=amd64 go build -o /usr/local/bin/gostart

FROM scratch AS runtime-stage
COPY --from=gobuilder-stage /usr/local/bin/gostart /usr/local/bin/gostart
CMD ["/usr/local/bin/gostart"]

