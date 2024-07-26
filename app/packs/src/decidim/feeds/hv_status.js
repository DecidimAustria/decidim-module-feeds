export function hv_status() {
  const changeStatusButtons = document.querySelectorAll('.changeStatusButton');
	changeStatusButtons.forEach(function (button) {
		button.addEventListener('click', function () {
			const postId = button.dataset.postId;
			const newStatus = button.dataset.postStatus;

			const confirmationModal = document.getElementById('confirmationModal');
			confirmationModal.showModal();
			const confirmButtons = confirmationModal.querySelector(
				'.confirmationModal__buttons'
			);
			const confirmationModalResponse = confirmationModal.querySelector(
				'.confirmationModal__response'
			);
			const confirmButton = document.getElementById(
				'confirmationModal__confirmButton'
			);
			const cancelButton = document.getElementById(
				'confirmationModal__cancelButton'
			);

			confirmButton.addEventListener('click', function () {
				confirmButtons.style.display = 'none';
				console.log()
				confirmationModalResponse.innerText =
					window.translations.dialog.dialogBodyResponse;
				const params = new URLSearchParams({
					id: postId,
					status: newStatus,
				});
				Rails.ajax({
					url: 'change_status/?' + params.toString(),
					type: 'GET',
					success: function (response) {
						console.log('Status changed successfully');
						confirmationModal.close();
						confirmButtons.style.display = 'flex';
						confirmationModalResponse.innerText =
							window.translations.dialog.dialogBodyMsg;
						const postElement = document.getElementById(`feeds_post-${postId}`);
						postElement.innerHTML = response.new_content;
            hv_status();
					},
					error: function (error) {
						console.error('Error changing status:', error);
					},
				});
			});
			cancelButton.addEventListener('click', function () {
				confirmationModal.close();
			});
		});
	});
}