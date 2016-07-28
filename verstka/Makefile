#SRC = src/*
BIN = `npm bin`

all: build

build:
	@env NODE_ENV=production $(BIN)/webpack ${ARGS}

serve:
	@#webpack-dev-server ${ARGS}
	@$(BIN)/coffee server.coffee ${ARGS}

watch:
	@env NODE_ENV=watch $(BIN)/webpack --watch ${ARGS}

clean:
	@rm -rf dist index.html

.PHONY: all test clean doc build watch
