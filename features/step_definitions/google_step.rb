Given("the user open the browser in access the {string}") do |site|
  base.accessSite(site)
end

And("set value for the search {string}") do |data|
 google.setSearch(data)
end

Then("verify the return of the search  {string}") do |data|
  google.verifySearch(data)
end