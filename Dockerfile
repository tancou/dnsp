FROM golang:1.21 as build

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod tidy

COPY . ./

RUN cd cmd/dnsp && \
    CGO_ENABLED=0 go build -buildvcs=false -o dnsp

FROM scratch

COPY --from=build /app/cmd/dnsp/dnsp /dnsp

EXPOSE 53

entrypoint ["/dnsp"]