# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    can :read, Course, state: 'approved'
    can :read, User
    return unless user.present?

    can :manage, User, id: user.id
    can :manage, Paper, state: 'in_progress', student_id: user.id
    can :read, Paper, state: 'marked', student_id: user.id
    can :read, Group, state: 'recruiting'
    can :read, Group do |g|
      return false if g.students.where(id: user.id).empty?

      (g.state == 'ready') || (g.state == 'completing')
    end

    can :read, Chapter do |chapter|
      return false if chapter.course.state != 'approved'

      user.access_to?(chapter)
    end
    can :read, Lecture do |lecture|
      return false if lecture.chapter.course.state != 'approved'

      user.access_to?(lecture)
    end
    can :read, Assignment do |assignment|
      return false if assignment.lecture.chapter.course.state != 'approved'

      user.access_to?(assignment)
    end
    return if user.role?(:student)

    can :create, [Course, Chapter, Lecture, Assignment, Group]
    can :read, [Group], teacher_id: user.id
    can %i[index_mine show_mine], Course, teacher_id: user.id, state: 'pending'
    can %i[index_mine show_mine], Course, teacher_id: user.id, state: 'rejected'
    can :read, Chapter, course: { teacher_id: user.id}
    can :read, Lecture, chapter: { course: { teacher_id: user.id}}
    can :read, Assignment, lecture: { chapter: { course: { teacher_id: user.id}}}
    can %i[update destroy], Course, state: 'pending', teacher_id: user.id
    can %i[update destroy], Chapter, course: { state: 'pending', teacher_id: user.id}
    can %i[update destroy], Lecture, chapter: { course: {state: 'pending', teacher_id: user.id}}
    can %i[update destroy], Assignment, lecture: {chapter: { course: {state: 'pending', teacher_id: user.id}}}
    can :update, Group, state: 'approved', teacher_id: user.id
    can :destroy, Group, state: 'approved', teacher_id: user.id
    can :destroy, Group, state: 'finished', teacher_id: user.id
    return unless user.role?(:admin)

    can :manage, :all
  end
end
