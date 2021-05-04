const String getMyNotificationsQuery = r"""
query{
	getMyNotifications{
		... on ConnectionNotificationSchema{
			id,
			from{
				id,
				name,
				username,
				avatarPath
			},
			createdAt,
			label
		}
	}
}
""";
