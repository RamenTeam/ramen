module.exports = {
	preset: "ts-jest",
	testEnvironment: "node",
	collectCoverageFrom: ["**/*.{ts,tsx}"],
	testPathIgnorePatterns: ["<rootDir>/dist/"],
};
