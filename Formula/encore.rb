class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.11"
    checksums = {
        "darwin_arm64" => "115438f84f0e6086ae90dc5510aff1222d5671a83bdf5a7570839dace617cf37",
        "darwin_amd64" => "c78db9c31e3c8d3ea5b4ea87662e8c0f587be4836817cabb58718d9ea19b5ea7",
        "linux_arm64"  => "6f52063b98367c5ae594629eadb3851c0d0ec6469e382347eb67e63be179d737",
        "linux_amd64"  => "ee291e14448f887d9f98aa7b696f16250138ddb190ed10168244de12809470dc",
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
