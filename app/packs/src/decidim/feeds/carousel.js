const carousel = (() => {
	let startX;

	const setActiveItem = (galleryId, index, direction = null) => {
		const galleryItems = document.querySelectorAll(`#${galleryId} li`);
		const navDots = document.querySelectorAll(
			`.feedGallery_nav_dot[data-target="${galleryId}"]`
		);
		let activeIndex = index;

		if (direction) {
			const currentIndex = Array.from(galleryItems).findIndex(
				(item) => !item.classList.contains('hidden')
			);
			if (direction === 'left' && currentIndex < galleryItems.length - 1) {
				activeIndex = currentIndex + 1;
			} else if (direction === 'right' && currentIndex > 0) {
				activeIndex = currentIndex - 1;
			}
		}

		galleryItems.forEach((item, idx) => {
			item.classList.toggle('hidden', idx !== activeIndex);
			if (idx === index) {
				item.classList.add('active');
			} else {
				item.classList.remove('active');
			}
		});

		navDots.forEach((dot, idx) => {
			dot.classList.toggle('shadow-feedNotification', idx === activeIndex);
			dot.classList.toggle('shadow-feedNotificationInset', idx !== activeIndex);
		});
	};

	const attachSwipeListeners = (galleryId) => {
		const gallery = document.getElementById(galleryId);

		gallery.addEventListener('touchstart', (e) => {
			startX = e.touches[0].clientX;
		});

		gallery.addEventListener('touchend', (e) => {
			const endX = e.changedTouches[0].clientX;
			if (startX - endX > 50) {
				setActiveItem(galleryId, null, 'left');
			} else if (startX - endX < -50) {
				setActiveItem(galleryId, null, 'right');
			}
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
		// Initialize swipe listeners for each gallery
		document.querySelectorAll('.feedGallery').forEach((gallery) => {
			attachSwipeListeners(gallery.id);
		});
	};

	return { init };
})();

export default carousel;
