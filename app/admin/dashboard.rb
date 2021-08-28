ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Usuarios" do
          ul do
            User.recent(25).map do |user|
              li link_to(user.email, admin_user_path(user))
            end
          end
        end
      end
      column do
        panel "Locales" do
          ul do
            Shop.recent(25).map do |shop|
              li link_to(shop.name, admin_shop_path(shop))
            end
          end
        end
      end
      column do
        panel "Vehículos" do
          ul do
            Vehicle.recent(25).map do |vehicle|
              li link_to(vehicle.plate, admin_vehicle_path(vehicle))
            end
          end
        end
      end
    end
    columns do
      column do
        panel "Solicitudes" do
          ul do
            ReplacementRequest.recent(25).map do |replacement_request|
              li link_to(replacement_request.short_name, admin_replacement_request_path(replacement_request))
            end
          end
        end
      end
      column do
        panel "Propuestas" do
          ul do
            ReplacementProposal.recent(25).map do |replacement_proposal|
              li link_to(replacement_proposal.name, admin_replacement_proposal_path(replacement_proposal))
            end
          end
        end
      end

      # column do
      #   panel "Info" do
      #     para "Welcome to ActiveAdmin."
      #   end
      # end
    end
  end # content
end
