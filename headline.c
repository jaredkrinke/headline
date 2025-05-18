#include <stddef.h>
#include "webview/webview.h"
#include "bundle.html.h"

int main() {
	webview_t window = webview_create(0, NULL);
	webview_set_title(window, "Headline RSS Reader");
	webview_set_size(window, 800, 600, WEBVIEW_HINT_NONE);
	webview_set_html(window, STRINGIFIED_HTML);
	webview_run(window);
	webview_destroy(window);
	return 0;
}

