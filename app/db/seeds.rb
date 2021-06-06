users = [
  { name: "John" },
  { name: "Mary" },
]

upserted = User.upsert_all(
  users,
  unique_by: [:name]
)

puts "#{upserted.count} user(s) upserted."
