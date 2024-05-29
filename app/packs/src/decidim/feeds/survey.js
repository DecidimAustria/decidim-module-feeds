export function initSurvey() {
	// Add event listener to the new survey button
	const liveRegion = document.getElementById(
		'feeds__feed_newSurvey_liveRegion'
	);
	document
		.querySelector('.feeds__feed_newSurvey-btn')
		.addEventListener('click', () => {
			const questionContainer = document.getElementById(
				'feeds__feed_newSurvey_questionsContainer'
			);
			const timestamp = Date.now();
			const newQuestionId = `newQuestion-${timestamp}`;

			// Create new question div
			const newQuestionDiv = document.createElement('div');
			newQuestionDiv.id = newQuestionId;
			newQuestionDiv.className = 'feeds__feed_newSurvey_question';

			// Create question title
			const questionTitleDiv = document.createElement('div');
			questionTitleDiv.className = 'feeds__feed_newSurvey_questionTitle';

			const label = document.createElement('label');
			label.htmlFor = `question${questionContainer.children.length + 1}`;
			label.textContent = window.translations.questionTitle;
			questionTitleDiv.appendChild(label);

			const input = document.createElement('input');
			input.type = 'text';
			input.id = `question${questionContainer.children.length + 1}`;
			input.name = `question${questionContainer.children.length + 1}`;
			input.value = '';
			questionTitleDiv.appendChild(input);

			newQuestionDiv.appendChild(questionTitleDiv);

			// Create fieldset with radio inputs
			const fieldset = document.createElement('fieldset');
			const legend = document.createElement('legend');
			legend.textContent = window.translations.answerType;
			fieldset.appendChild(legend);
			[
				window.translations.singleChoice,
				window.translations.multipleChoice,
			].forEach((option, index) => {
				const input = document.createElement('input');
				input.type = 'radio';
				input.id = `option-${timestamp}-${index + 1}`;
				input.name = `question-${timestamp}`;
				input.className = 'sr-only';
				const label = document.createElement('label');
				label.htmlFor = input.id;
				label.textContent = option;
				label.className = 'button button__sm button__transparent-primary';
				fieldset.appendChild(input);
				fieldset.appendChild(label);
			});
			newQuestionDiv.appendChild(fieldset);

			// Create initially invisible answer container with a button
			const answerContainer = document.createElement('div');
			answerContainer.className = 'feeds__feed_newSurvey_answerContainer';
			answerContainer.style.display = 'none';
			const answersContainer = document.createElement('div');
			answersContainer.className = 'feeds__feed_newSurvey_answers';
			answerContainer.appendChild(answersContainer);
			const button = document.createElement('button');
			button.textContent = window.translations.newAnswer;
			button.type = 'button';
			button.className = 'button button__sm button__transparent-primary';
			answerContainer.appendChild(button);

			// Define the number of answers
			const numberOfAnswers = 2;

			for (let i = 0; i < numberOfAnswers; i++) {
				createNewAnswer(timestamp, answersContainer, liveRegion);
			}

			newQuestionDiv.appendChild(answerContainer);

			// Append new question to the questions container
			questionContainer.appendChild(newQuestionDiv);

			liveRegion.textContent = window.translations.newQuestionResponse;

			// Add event listeners to the radio buttons
			fieldset
				.querySelectorAll('input[type="radio"]')
				.forEach((radioButton) => {
					radioButton.addEventListener('change', () => {
						// Show the answer container when a radio button is selected
						answerContainer.style.display = 'block';
					});
				});

			// Add event listener to the new answer button
			button.addEventListener('click', () => {
				createNewAnswer(timestamp, answersContainer, liveRegion);
			});

			// Set the button type to "button"
			button.type = 'button';
		});

	function createNewAnswer(timestamp, answersContainer, liveRegion) {
		const newAnswerDiv = document.createElement('div');
		newAnswerDiv.className = 'feeds__feed_newSurvey_answer';
		newAnswerDiv.id = `answer-${timestamp}-${answersContainer.children.length}`;
		console.log(answersContainer, answersContainer.children.length);
		// Create label for the answer
		const label = document.createElement('label');
		label.htmlFor = newAnswerDiv.id;
		label.textContent = `${answersContainer.children.length + 1}. `;
		newAnswerDiv.appendChild(label);

		// Create input for the answer
		const input = document.createElement('input');
		input.type = 'text';
		input.id = `answerInput-${newAnswerDiv.id}`;
		input.name = newAnswerDiv.id;
		newAnswerDiv.appendChild(input);

		// Append new answer to the answer container
		answersContainer.appendChild(newAnswerDiv);

		liveRegion.textContent = window.translations.newQuestionResponse;
	}
}
