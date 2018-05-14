# frozen_string_literal: true

ViodeSettings = JSON.parse Rails.application.config_for(:settings).to_json, object_class: OpenStruct
