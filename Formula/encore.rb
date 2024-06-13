class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.8"
    checksums = {
        "darwin_arm64" => "1481f64c726ec4f8409ec10207ac02f7f2fb8d836528f080f53e594b0ff69ece",
        "darwin_amd64" => "8f4314146774c533c03dbacbde1051c935e91f4515bd7a95f99b1dbb2c092238",
        "linux_arm64"  => "16e5f0e175a57f64f8f790ce16679f855ba5a63cf3b5fc93cd5b4c380aef5321",
        "linux_amd64"  => "968cfe647cd547566a8e24260dcedb4f0cd207ce983a8e69b02059251e6c17fe",
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
