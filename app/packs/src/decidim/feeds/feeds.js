import { initSurvey } from './survey.js';

document.addEventListener('DOMContentLoaded', function () {
	const newFeed = document.querySelector('.feeds__feed_newElement');
	const newFeedOpener = document.querySelector(
		'.feeds__feed_newElement-opener'
	);

	newFeedOpener.addEventListener('click', function () {
		let isExpanded = newFeedOpener.getAttribute('aria-expanded') === 'true';
		newFeedOpener.setAttribute('aria-expanded', !isExpanded);
		newFeed.classList.toggle('open');
	});

	const newFeedForm = document.querySelector('.feeds__feed_newElement form');
	const newFeedFormPostType = newFeedForm.querySelectorAll(
		'.postType input[type="radio"]'
	);

	const newFeedCalendarForm = document.getElementById('extraFieldsForCalendar');
	const newFeedSurveyForm = document.getElementById('extraFieldsForSurvey');

	newFeedFormPostType.forEach(function (radio) {
		radio.addEventListener('change', function () {
			// Hide all forms
			newFeedCalendarForm.classList.remove('open');
			newFeedSurveyForm.classList.remove('open');

			// Display the extra fields for the selected radio button
			if (this.value === 'calendar') {
				newFeedCalendarForm.classList.add('open');
			} else if (this.value === 'survey') {
				newFeedSurveyForm.classList.add('open');
			}
		});
	});

	document
		.querySelectorAll('.feeds__feed_actions_submenu button')
		.forEach(function (button) {
			button.addEventListener('click', function () {
				var submenuId = this.getAttribute('aria-controls');
				var submenu = document.getElementById(submenuId);
				var isHidden = submenu.classList.contains('hidden');

				submenu.classList.toggle('hidden', !isHidden);
				this.setAttribute('aria-expanded', !isHidden);
			});
		});

	initSurvey();
});
