export const getFullDayTime = () => {
	const today = new Date();
	return `${
		today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate()
	}|${today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds()}`;
};
