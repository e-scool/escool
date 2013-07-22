module Api
  class TestController < ApplicationController

    respond_to :json

    #
    # Only for testing mobile client. TODO: Remove
    #
    def communications_index
      classroom = Classroom.first
      communications = []

      5.times do |c|
        c = classroom.communications.new
        c.id = '234'
        c.classroom = classroom
        c.children = classroom.children
        c.subject = Subject.first
        c.title = 'Jornada de portes obertes'
        c.body = 'El proper dimarts farem la jornada de portes obertes'
        c.date = Time.now
        communications << c
      end

      respond_with communications
    end

    #
    # Only for testing mobile client. TODO: Remove
    #
    def communications_show
      classroom = Classroom.first

      c = classroom.communications.new
      c.id = params[:id]
      c.classroom = classroom
      c.children = classroom.children
      c.subject = Subject.first
      c.title = 'Jornada de portes obertes'
      c.body = 'El proper dimarts farem la jornada de portes obertes'
      c.date = Time.now

      respond_with c
    end

  end
end