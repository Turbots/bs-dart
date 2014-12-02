import 'package:polymer/polymer.dart';
import 'dart:html';

void main() {
	initPolymer().run(() {
		Polymer.onReady.then(_onReady);
	});
}

_onReady(dynamic value) {
}

@CustomTag("test-app")
class TestApp extends PolymerElement {

	TestApp.created() : super.created();

	@observable bool dialogOpen = false;

	open(Event e, var detail, Node target) {
		dialogOpen = true;
	}

	closeDialog(Event e, var detail, Node target) {
		dialogOpen = false;
	}
}
