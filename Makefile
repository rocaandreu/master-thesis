FILE := main
OUT  := build

.PHONY: pdf
pdf:
	latexmk -interaction=nonstopmode -outdir=$(OUT) -pdf -halt-on-error $(FILE)
	makeglossaries -d build main
	latexmk -interaction=nonstopmode -outdir=$(OUT) -pdf -halt-on-error $(FILE)

.PHONY: watch
watch:
	latexmk -interaction=nonstopmode -outdir=$(OUT) -pdf -pvc -halt-on-error $(FILE)

.PHONY: clean
clean:
	rm -rf $(filter-out $(OUT)/$(FILE).pdf, $(wildcard $(OUT)/*))

.PHONY: purge
purge:
	rm -rf $(OUT)

.PHONY: cover
cover:
	# pdftk build/main.pdf img/first-page.pdf cat 1 2-end output build/main_with_cover.pdf
	pdftk A=img/first-page.pdf B=build/main.pdf cat A1 B2-end output build/tfm_andreu_roca.pdf

