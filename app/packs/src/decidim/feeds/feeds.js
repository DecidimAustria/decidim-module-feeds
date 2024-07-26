import { initSurvey } from './survey.js';
import carousel from './carousel.js';
import { hv_status } from './hv_status.js';

document.addEventListener('DOMContentLoaded', function () {
	console.log('js loaded');

	const newFeed = document.querySelector('.feeds__feed_newElement');
	const newFeedOpener = document.querySelectorAll(
		'.feeds__feed_newElement-opener'
	);

	newFeedOpener.forEach(function (opener) {
		opener.addEventListener('click', function () {
			// Scroll to the top if not already at the top and the feed is not already open
			if (window.scrollY > 0) {
				window.scrollTo({
					top: 0,
				});
			}
			let isExpanded = opener.getAttribute('aria-expanded') === 'true';
			opener.setAttribute('aria-expanded', !isExpanded);
			newFeed.classList.toggle('open');
		});
	});

	const categoryButtons = document.querySelectorAll(
		'.category-selection button'
	);
	const meetingForm = document.querySelector('.meetings_form');
	const postForm = document.querySelector('.posts_form');
	const surveyDiv = document.getElementById('extraFieldsForSurvey');

	function hideAllForms() {
		meetingForm.classList.remove('open');
		postForm.classList.remove('open');
		surveyDiv.classList.remove('open');
		categoryButtons.forEach((button) => button.classList.remove('active'));
	}

	categoryButtons.forEach((button) => {
		button.addEventListener('click', function () {
			hideAllForms(); // Clear active states before setting the new one
			this.classList.add('active'); // Mark the clicked button as active

			const category = this.getAttribute('data-category');

			if (category === 'calendar') {
				meetingForm.classList.add('open');
			} else if (category === 'survey') {
				postForm.classList.add('open');
				surveyDiv.classList.add('open');
				document.getElementById('post_category').value = category;
			} else {
				postForm.classList.add('open');
				document.getElementById('post_category').value = category;
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
				controlledDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
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
	hv_status();
});
