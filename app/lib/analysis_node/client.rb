module AnalysisNode
  class Client
    class AnalysisError < StandardError; end

    # e.g 
    def some_action(args:)
      response = exec(command(:some_action, args: args))
      JSON.parse(response).deep_symbolize_keys
    end

    def exec(command)
      response = `#{bin_path.join(" ")} #{command.join(" ")} 2>&1`
      if $?.success?
        response
      else
        raise(AnalysisError, response)
      end
    end

    private

    def bin_path
      [
        ENV.fetch("ANALYSIS_BIN"),
      ]
    end

    def command(name, args: [])
      args = normalize_params(args)
      args.unshift(name)
    end

    def normalize_params(command)
      command.map { |param|
        if param.respond_to?(:iso8601)
          param.iso8601
        else
          param
        end
      }
    end
  end
end
