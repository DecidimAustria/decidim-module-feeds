document.addEventListener('DOMContentLoaded', function () {
	console.log('feed JS really loaded');
	const newFeed = document.querySelector('.feeds__feed_newElement');
	const newFeedOpener = document.querySelector(
		'.feeds__feed_newElement-opener'
	);

	newFeedOpener.addEventListener('click', function () {
		let isExpanded = newFeedOpener.getAttribute('aria-expanded') === 'true';
		newFeedOpener.setAttribute('aria-expanded', !isExpanded);
		newFeed.classList.toggle('open');
	});
});
