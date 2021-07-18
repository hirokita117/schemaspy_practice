FROM golang:1.15-alpine as builder

ENV CGO_ENABLED 0

RUN apk add --no-cache git
RUN go get -u github.com/skeema/skeema

WORKDIR /skeema

COPY . .

### Production image ###
FROM builder as production

CMD ["skeema"]

### Development image ###
FROM builder as development

RUN apk update
RUN apk add curl bash

RUN curl -O https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x wait-for-it.sh

RUN echo "" | tee -a .skeema
RUN echo "[test]" | tee -a .skeema
RUN echo "flavor=mysql:5.7" | tee -a .skeema
RUN echo "host=db" | tee -a .skeema
RUN echo "port=3306" | tee -a .skeema
RUN echo "user=root" | tee -a .skeema
RUN echo "password=XXXX" | tee -a .skeema
RUN echo "lint-pk=ignore" | tee -a .skeema
RUN echo "lint-dupe-index=ignore" | tee -a .skeema

CMD ["skeema"]
