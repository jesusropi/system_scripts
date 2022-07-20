# To convert markdown into docx
# For more information visit:
# https://waylonwalker.com/til/convert-markdown-pdf-linux/
# https://pandoc.org
pandoc pages/til/convert-markdown-pdf-linux.md -o convert-markdown-pdf.pdf --latex-engine=xelatex

# To convert markdown from notion into anki akpg
# For more information visit: 
# https://github.com/lukesmurray/markdown-anki-decks
mdankideck input/ output/