library bs.modal;

import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag("bs-modal")
class BootstrapModal extends PolymerElement {

	DivElement _backdrop;
	String _transitionEndEvents = "webkitTransitionEnd,otransitionend,oTransitionEnd,msTransitionEnd,transitionend";

	@published bool open = false;

	BootstrapModal.created() : super.created();

	openChanged(var oldValue, var newValue) {
		if (open) {
			_backdrop = new DivElement()
					..on["tap"].listen((Event e) => backgroundTap)
					..className = "modal-backdrop fade"
					..addEventListener("click", (Event e) => this.backgroundTap);
			document.body.append(_backdrop);
			_backdrop.offsetWidth;
			_backdrop.classes.add("in");
			this._transitionEndEvents.split(",").forEach((String type) => _backdrop.addEventListener(type, backdropTransDone));
		} else {
			DivElement container = $["container"];
			container.classes.remove("in");
			container.attributes["aria-hidden"] = "true";
		}
	}

	backdropTransDone(Event e) {
		if (open) {
			DivElement container = $["container"];
			container.style.display = "block";
			container.offsetWidth;
			container.classes.add("in");
			container.attributes["aria-hidden"] = "false";
			document.body.classes.add("modal-open");
		} else {
			_backdrop.parent.children.remove(_backdrop);
			_backdrop = null;
			document.body.classes.remove("modal-open");
		}
	}

	containerTransDone(Event e) {
		if (!open) {
			DivElement container = $["container"];
			container.style.display = "none";
			_backdrop.classes.remove("in");
		}
	}

	backgroundTap(Event e) {
		dispatchEvent(new CustomEvent("backgroundtap"));
	}

	modalTap(Event e) {
		e.stopPropagation();
	}

	ready() {
		DivElement container = $["container"];
		this._transitionEndEvents.split(",").forEach((String type) => container.addEventListener(type, containerTransDone));
	}
}
