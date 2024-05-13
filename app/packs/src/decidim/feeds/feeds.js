document.addEventListener('DOMContentLoaded', function () {
	console.log('feed JS loaded');
	const feedActions = document.querySelector('.feed__actions');
	const toggleIcon = feedActions.querySelector('.icon');
	const firstItem = feedActions.querySelector('li:first-child');

	firstItem.addEventListener('click', function () {
		let isExpanded = firstItem.getAttribute('aria-expanded') === 'true';
		firstItem.setAttribute('aria-expanded', !isExpanded);
		feedActions.classList.toggle('expanded');
		toggleIcon.classList.toggle('arrow-down-s-line');
		toggleIcon.classList.toggle('arrow-up-s-line');
	});
});
