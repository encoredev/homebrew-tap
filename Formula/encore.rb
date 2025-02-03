class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.4"
    checksums = {
        "darwin_arm64" => "a1173e278b6afce3d1b3b4daa088b178661981741c5fba09f4d71cf4ddff5d7b",
        "darwin_amd64" => "f984057dfaf391f67b683ce3c03f914099dcf940c437eecc2cf71567a3be6fb6",
        "linux_arm64"  => "7f573a1661afea208136c60131f2fd595129407362969d65f0fd5dfa8ba0d7dc",
        "linux_amd64"  => "cd77fc4fc62ff5419a2724640339878d9bfd098f715a697e2817ffd7c2f5d3f3",
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
