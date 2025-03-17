class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.10"
    checksums = {
        "darwin_arm64" => "041c630a07ec0ce3fcdf609886ef11a453a9ff807a1fa53bc8270cb75d414c73",
        "darwin_amd64" => "b22102f853464e673ae2a31f337ddd02f5f669259f08223ce2330e4e14795b9e",
        "linux_arm64"  => "6370e124a393b994750cfe3b089a5ee93293c71e20231a964b3a3cde83cd42ca",
        "linux_amd64"  => "b4350ef8a8e95ca1d984c9b914927cf6dabdedf96c9ddfd377aee642de0b198d",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
