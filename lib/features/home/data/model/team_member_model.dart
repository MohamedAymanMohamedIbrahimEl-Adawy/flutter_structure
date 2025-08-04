class TeamMember {
  final String name;
  final String role;
  final bool online;
  const TeamMember({
    required this.name,
    required this.role,
    this.online = false,
  });
}
