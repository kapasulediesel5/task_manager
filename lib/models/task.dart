import 'dart:convert';
import 'package:flutter/material.dart';

enum Category { work, leisure, travel }

enum Status { complete, inComplete }

// Category Icons
final categoryIcons = {
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.travel: Icons.flight_takeoff
};

class Task {
  // task title
  final String title;

  // task description
  final String description;

  //task Category
  final Category category;

  // task Completion Status
  Status status;

  Task(
      {required this.title,
      required this.description,
      required this.category,
      this.status = Status.inComplete});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': 'inComplete',
      'category': category
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      category: map['category'],
      status: map['Incomplete'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
