CONTENT      := $(wildcard content/*.html)

PNG          := $(wildcard asset/image/*.png)
GIF          := $(wildcard asset/image/*.gif)
IMAGE				 := $(PNG:asset/%.png=dist/%.png) $(GIF:asset/%.gif=dist/%.gif)

build: $(IMAGE)
	metalsmith

dist/%.css: asset/%.css
	@mkdir -p $(@D)
	@cp $< $@
	
dist/%.png: asset/%.png
	mkdir -p $(@D)
	cp $< $@

dist/%.gif: asset/%.gif
	mkdir -p $(@D)
	cp $< $@

deploy: build
	cd dist && \
	echo "kjaertbarn.no" > CNAME && \
	git init . && \
	git add . && \
	git commit -m "Deploy --skip-ci"; \
	git push "git@github.com:qup/kjaertbarn.git" master:gh-pages --force && \
	rm -rf .git
	
clean:
	rm -r dist
