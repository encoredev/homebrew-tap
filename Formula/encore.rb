class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.26.0"
    checksums = {
        "darwin_arm64" => "8964cec4580d37eecf072a482bb4c247943e1472c14b126caa9ba687d4762f40",
        "darwin_amd64" => "4a69f3f4b1eef9ac52fa7dde96d5ec6022bcbb738809bc0cacf43df4936adcf0",
        "linux_arm64"  => "b2ea405c6eb0a5a70b633f17aea9c236ae8fbcaf4a5def5b14a578c24c6eb8d0",
        "linux_amd64"  => "c76d2183a15ced54259dc2a0b9c76b48f8a211494e0a0590ddb9d0f9dc0a925c",
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
