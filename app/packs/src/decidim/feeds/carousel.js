const carousel = (() => {
	const setActiveItem = (galleryId, index) => {
		const galleryItems = document.querySelectorAll(`#${galleryId} li`);
		const navDots = document.querySelectorAll(
			`.feedGallery_nav_dot[data-target="${galleryId}"]`
		);

		galleryItems.forEach((item, idx) => {
			item.classList.toggle('hidden', idx !== index);
		});

		navDots.forEach((dot, idx) => {
			dot.classList.toggle('shadow-feedNotification', idx === index);
			dot.classList.toggle('shadow-feedNotificationInset', idx !== index);
		});
	};

	const attachEventListenersToDots = () => {
		document.querySelectorAll('.feedGallery_nav_dot').forEach((dot) => {
			dot.addEventListener('click', function () {
				const targetGalleryId = this.getAttribute('data-target');
				const targetIndex = parseInt(this.getAttribute('data-index'), 10);
				setActiveItem(targetGalleryId, targetIndex);
			});
		});
	};

	const init = () => {
		attachEventListenersToDots();
	};

	return { init };
})();

export default carousel;
