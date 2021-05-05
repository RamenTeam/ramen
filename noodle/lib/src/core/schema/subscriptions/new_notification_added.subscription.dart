const String newNotificationAddedSubscription = r"""
subscription{
	newNotificationAdded{
		... on ConnectionNotificationSchema{
			id,
			from{
				id,
				name,
				username,
				avatarPath
			},
			createdAt,
		}
	}
}
""";
