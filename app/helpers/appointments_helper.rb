module AppointmentsHelper
  def change_state(type_of_user)
    appointment_old_admin = @appointment.admin if !@appointment.admin.nil?
    if @appointment.verify_status_change(appointment_change_state_params[:status].to_i, type_of_user)
      @appointment.status = appointment_change_state_params[:status].to_i
    else
      apt = Appointment.new(status: appointment_change_state_params[:status].to_i)
      render status: 400, json: {message: I18n.translate('models.appointment.cant_change_status', new_status: apt.status_string)}
      return
    end
    if current_user.present? and !current_admin.present?
      unless @appointment.user == current_user
        render status: 400, json: {message: I18n.translate('models.appointment.not_owner')}
        return
      end

      unless @appointment.date - Time.now >= 24.hours
        render status: 400, json: {message: I18n.translate('models.appointment.cant_cancel_before_24_hours')}
        return
      end
    end
    if current_admin.present?
      @appointment.admin = current_admin
    end
    if @appointment.save
      if @appointment.status == Appointment::CANCELED
        UserMailer.canceled_appointment_mail(@appointment.user,@appointment.date.to_i).deliver_later
      end
      render status: 200, json: {success: I18n.translate('models.appointment.status_changed', new_status: @appointment.status_string)}
    else
      @appointment.admin = appointment_old_admin
      render status: 400, json: {message: @appointment.errors.full_messages.join('\n')}
    end
  end
end
