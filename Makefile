ROOT = .

COFFEE_LOC = $(ROOT)/src/coffee
COFFEE_FILES = $(wildcard $(COFFEE_LOC)/*.coffee)

JS_LOC = $(ROOT)/scripts
JS_BUILT = $(JS_LOC)/.built
JS_FILES = $(addprefix $(JS_LOC)/,$(notdir $(COFFEE_FILES:.coffee=.js)))
ALL_JS_FILES = $(wildcard $(JS_LOC)/*.js)

SASS_LOC = $(ROOT)/src/sass
SASS_FILES = $(wildcard $(SASS_LOC)/*.sass)
SASS_FILE = $(SASS_LOC)/style.sass

CSS_LOC = $(ROOT)/styles
CSS_FILE = $(CSS_LOC)/style.css

JADE_LOC = $(ROOT)/src/jade
JADE_FILES = $(wildcard $(JADE_LOC)/*.jade)

HTML_LOC = $(ROOT)
HTML_FILES = $(addprefix $(HTML_LOC)/,$(notdir $(JADE_FILES:.jade=.html)))


all: $(JS_BUILT) $(CSS_FILE) $(HTML_FILES)


$(JS_BUILT): $(JS_FILES)
	touch $@

$(JS_LOC)/%.js: $(COFFEE_LOC)/%.coffee
	coffee --output $(JS_LOC) --compile $<

$(CSS_FILE): $(SASS_FILES)
	mkdir -p $(CSS_LOC)
	sass $(SASS_FILE):$(CSS_FILE)

$(HTML_LOC)/%.html: $(JADE_LOC)/%.jade
	jade -o $(HTML_LOC) $(JADE_LOC)

clean:
	@rm -f $(CSS_FILE) $(ALL_JS_FILES) $(JS_BUILT)

deploy:
	git push -f origin master:gh-pages

.PHONY: all clean deploy
