const carousel = (() => {
	const setActiveItem = (index) => {
		const galleryItems = document.querySelectorAll('#galleryItems li');
		const navDots = document.querySelectorAll('#navDots .dot');

		galleryItems.forEach((item, idx) => {
			item.classList.toggle('hidden', idx !== index);
		});

		navDots.forEach((dot, idx) => {
			dot.classList.toggle('bg-gray-4', idx === index);
			dot.classList.toggle('bg-gray-2', idx !== index);
		});
	};

	const initCarousel = () => {
		const navDots = document.querySelectorAll('#navDots .dot');

		navDots.forEach((dot, index) => {
			dot.addEventListener('click', () => {
				setActiveItem(index);
			});
		});
	};

	return { initCarousel };
})();

export default carousel;
