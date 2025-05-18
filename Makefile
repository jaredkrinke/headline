CFLAGS = -fPIC `pkg-config --cflags gtk+-3.0 webkit2gtk-4.1`
CXXFLAGS = $(CFLAGS)
LDFLAGS = -lstdc++ `pkg-config --libs gtk+-3.0 webkit2gtk-4.1`

default: bundle.html.h headline

# TODO: bundle images?
bundle.html: index.html styles.css app.js
	cp index.html bundle.html
	echo '<style>' > tmp.txt
	cat styles.css >> tmp.txt
	echo '</style>' >> tmp.txt
	sed -i '/<link rel="stylesheet" href="styles.css" \/>/r tmp.txt' $@
	sed -i '/<link rel="stylesheet" href="styles.css" \/>/d' $@
	echo '<script>' > tmp.txt
	cat app.js >> tmp.txt
	echo '</script>' >> tmp.txt
	sed -i '/<script src="app.js"><\/script>/r tmp.txt' $@
	sed -i '/<script src="app.js"><\/script>/d' $@
	rm -f tmp.txt

bundle.html.h: bundle.html
	echo "#define STRINGIFIED_HTML \\" > $@
	cat $< |sed -f stringify.sed >> $@

headline: headline.o webview.o
	cc $^ $(LDFLAGS) -o $@

clean:
	rm -f *.o headline bundle.html *.html.h

