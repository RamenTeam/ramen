export const getCookieRoute = (app) =>
	app.get("/get-cookie", (req, res) =>
		res.status(200).json({
			cookie: req.cookies,
		})
	);
