document.addEventListener('DOMContentLoaded', function () {
	console.log('feeds.js has loaded');

	const button = document.querySelector('.feeds_popup_btn');
	const popup = document.getElementById('feeds_popup');

	if (button && popup) {
		const isTouchDevice = 'ontouchstart' in document.documentElement;
		let hideTimeout; // Reference for debounce or timeout management

		// Utility to toggle the popup's visibility
		const showPopup = function (e) {
			e.preventDefault();
			const btn_icon = button.querySelector('.icon');
			if (!btn_icon) {
				console.error('Button icon not found for positioning');
				return;
			}

			const rect = btn_icon.getBoundingClientRect();
			popup.style.left = `${rect.left - 36}px`;
			popup.classList.remove('hidden');
			button.setAttribute('aria-expanded', 'true');
		};

		const hidePopup = function () {
			popup.classList.add('hidden');
			button.setAttribute('aria-expanded', 'false');
			button.focus(); // Return focus to the button
		};

		// Debounce utility to handle rapid mouse events
		const debounce = (callback, delay) => {
			clearTimeout(hideTimeout);
			hideTimeout = setTimeout(callback, delay);
		};

		if (isTouchDevice) {
			button.addEventListener('touchstart', function (e) {
				if (!popup.classList.contains('hidden')) {
					hidePopup();
				} else {
					showPopup(e);
				}
				e.preventDefault();
			});
		} else {
			// Prevent default click behavior
			button.addEventListener('click', function (e) {
				e.preventDefault();
			});

			// Show popup on mouseenter
			button.addEventListener('mouseenter', showPopup);

			// Hide popup on mouseleave with debounce
			button.addEventListener('mouseleave', function () {
				debounce(() => {
					if (!popup.matches(':hover')) {
						hidePopup();
					}
				}, 150);
			});

			// Hide popup when mouse leaves popup area
			popup.addEventListener('mouseleave', hidePopup);

			// Clear hide timeout if re-entering popup
			popup.addEventListener('mouseenter', function () {
				clearTimeout(hideTimeout);
			});

			// Add keyboard support for Enter and Escape
			button.addEventListener('keydown', function (e) {
				if (e.key === 'Enter') {
					// Toggle popup visibility on Enter
					if (!popup.classList.contains('hidden')) {
						hidePopup();
					} else {
						showPopup(e);
						// Focus the first focusable element in the popup for accessibility
						const firstFocusable = popup.querySelector(
							'a, button, input, [tabindex="0"]'
						);
						if (firstFocusable) firstFocusable.focus();
					}
				}
			});

			document.addEventListener('keydown', function (e) {
				if (e.key === 'Escape' && !popup.classList.contains('hidden')) {
					hidePopup();
				}
			});
		}
	}
});
