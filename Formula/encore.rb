class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.27.6"
    checksums = {
        "darwin_arm64" => "98be9ba20cdacb5574e03f89dc8ec8af32a64aed0687dbd104281f6f86d6ee36",
        "darwin_amd64" => "e5cdd9605004d576ae7b87b7933063970cc05b4e4580eab44f702bb9d1c381b6",
        "linux_arm64"  => "f90516bc614f828e7df990eabd052e6dd1aed89b98a3a535812b181055c3a3c8",
        "linux_amd64"  => "a4a1dcb74bd5daba5919a4b32162333c0dc24cd1b11f25b10e24a7a0f06672a2",
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
