local minit = require("minit")

print(minit.name)

if not minit.fetchTar({ url = "https://example.url" }) then
	error("could not fetch tar")
end
