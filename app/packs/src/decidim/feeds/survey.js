export function initSurvey() {
	// Add event listener to the new survey button
	const liveRegion = document.getElementById(
		'feeds__feed_newSurvey_liveRegion'
	);
	const newSurveyButton = document.querySelector('.feeds__feed_newSurvey-btn');
	if (newSurveyButton)
		newSurveyButton.addEventListener('click', () => {
			const questionContainer = document.getElementById(
				'feeds__feed_newSurvey_questionsContainer'
			);

			// copy content from question_template to questionContainer
			const template = document.getElementById('question_template');
			var content = template.innerHTML.replace(
				/NEW_RECORD/g,
				new Date().getTime()
			);
			questionContainer.insertAdjacentHTML('beforeend', content);
			liveRegion.textContent =
				window.translations.newSurvey.newQuestionResponse;
		});

	// TODO: this does not work as the button does not exist yet and there will be multiple buttons
	document.addEventListener('click', (event) => {
		if (event.target.classList.contains('feeds__feed_newAnswer-btn')) {
			const questionId = event.target.dataset.questionId;
			// get div with class feeds__feed_newSurvey_answersContainer inside the same container as the clicked button
			const answerContainer = document.getElementById(
				`feeds__feed_newSurvey_answersContainer-${questionId}`
			);

			const questionAnswers = answerContainer.children.length + 1;
			// answerContainer.dataset.questionAnswers = questionAnswers;

			// copy content from question_template to questionContainer
			const template = document.getElementById('answer_template');
			var content = template.innerHTML.replace(
				/NEW_RECORD/g,
				new Date().getTime()
			);
			content = content.replace(/QUESTION_RECORD/g, questionId);
			content = content.replace(/ANSWER_NR/g, questionAnswers);

			answerContainer.insertAdjacentHTML('beforeend', content);
			liveRegion.textContent = window.translations.newSurvey.newAnswerResponse;
		}
	});

	document.querySelectorAll('.survey-answer-checkbox').forEach(checkbox => {
		checkbox.addEventListener('change', (event) => {
			const questionId = event.target.dataset.questionId;
			const answerId = event.target.dataset.answerId;
			const checked = event.target.checked;
			console.log(questionId, answerId, checked);
			Rails.ajax({
				url: 'user_answers/',
				type: 'GET',
					data: new URLSearchParams({
					question_id: questionId,
					answer_id: answerId,
					checked: checked
					}),
				success: function(response) {
					console.log(response);
					for (const [answerId, counter] of Object.entries(response.user_answers)) {
						// for each user_answer, change the width of the progress bar
						const progressBar = document.getElementById(`answer-${answerId}-progressbar`);
						const percentage = response.survey_responses_count > 0 ? (counter / response.survey_responses_count * 100) : 0;
						progressBar.style.width = `${percentage}%`;
						const counterSpan = document.getElementById(`answer-${answerId}-counter`);
						counterSpan.textContent = counter;
						const totalSpan = document.getElementById(`answer-${answerId}-total`);
						totalSpan.textContent = `${response.survey_responses_count}`;
					}
				},
				error: function(xhr, status, error) {
					console.log(xhr, status, error);
				}
			});
		});
	});

	function createNewQuestion_old() {
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
		label.textContent = window.translations.survey.questionTitle;
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
		legend.textContent = window.translations.survey.answerType;
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
		button.textContent = window.translations.survey.newAnswer;
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

		liveRegion.textContent = window.translations.survey.newQuestionResponse;

		// Add event listeners to the radio buttons
		fieldset.querySelectorAll('input[type="radio"]').forEach((radioButton) => {
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
	}

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

		liveRegion.textContent = window.translations.survey.newQuestionResponse;
	}
}
