import { initSurvey } from './survey.js';
import carousel from './carousel.js';

document.addEventListener('DOMContentLoaded', function () {
	console.log('js loaded');

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
		.querySelectorAll('.feeds__feed_actions_submenu > button')
		.forEach(function (button) {
			button.addEventListener('click', function () {
				var submenuId = this.getAttribute('aria-controls');
				var submenu = document.getElementById(submenuId);
				var isHidden = submenu.classList.contains('hidden');

				submenu.classList.toggle('hidden', !isHidden);
				this.setAttribute('aria-expanded', !isHidden);
			});
		});

	// comments

	// Select all comments__header h2 elements
	const commentsHeaders = document.querySelectorAll('.comments__header h2');
	// Loop over all h2 elements
	commentsHeaders.forEach((commentsHeader) => {
		// Find the parent container with "data-decidim-comments"
		const parentContainer = commentsHeader.closest('[data-decidim-comments]');
		// Get the ID of the parent container
		const parentId = parentContainer.getAttribute('id');
		// Set the aria-controls attribute to the h2 element
		commentsHeader.setAttribute('aria-controls', `${parentId}-threads`);
		// Set the aria-expanded attribute to false initially
		commentsHeader.setAttribute('aria-expanded', 'false');
	});

	const newCommentBtns = document.querySelectorAll('.newCommentBtn');
	const showCommentsBtns = document.querySelectorAll('.comments__header h2');

	newCommentBtns.forEach((newCommentBtn) => {
		newCommentBtn.addEventListener('click', function () {
			const controlledDivId = newCommentBtn.getAttribute('aria-controls');
			const controlledDiv = document.getElementById(controlledDivId);
			const isExpanded = newCommentBtn.getAttribute('aria-expanded') === 'true';
			newCommentBtn.setAttribute('aria-expanded', !isExpanded);
			if (isExpanded) {
				controlledDiv.style.height = '0';
				controlledDiv.style.visibility = 'hidden';
				controlledDiv.style.marginTop = '0';
			} else {
				controlledDiv.style.height = 'auto';
				controlledDiv.style.visibility = 'visible';
				controlledDiv.style.marginTop = '8px';
				controlledDiv.scrollIntoView({ behavior: 'smooth', block: 'start' });
			}
		});
	});

	showCommentsBtns.forEach((showCommentsBtn) => {
		showCommentsBtn.addEventListener('click', function () {
			const controlledDivId = showCommentsBtn.getAttribute('aria-controls');
			const controlledDiv = document.getElementById(controlledDivId);
			const isExpanded =
				showCommentsBtn.getAttribute('aria-expanded') === 'true';
			showCommentsBtn.setAttribute('aria-expanded', !isExpanded);
			if (isExpanded) {
				controlledDiv.style.height = '0';
				controlledDiv.style.visibility = 'hidden';
				controlledDiv.style.marginTop = '0';
			} else {
				controlledDiv.style.height = 'auto';
				controlledDiv.style.visibility = 'visible';
				controlledDiv.style.marginTop = '8px';
			}
		});
	});

	initSurvey();
	carousel.init();
});
