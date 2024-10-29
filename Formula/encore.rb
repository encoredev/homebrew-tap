class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.6"
    checksums = {
        "darwin_arm64" => "adda314b92055e2592c3dc9694fd0e241a6a626921c92750ace860cf3e3dbead",
        "darwin_amd64" => "43f4e583ff16502abea7fa6b6ee554338997a82a90d6f5ffdaa756bdb3c4c242",
        "linux_arm64"  => "982c33d34c5cb3bc32fa0068ee4ccecc033719fb0d26c9c63a1a632c45901af5",
        "linux_amd64"  => "185c9d294f5f88c1b1ac749d01f30a4a0fc38fb411f8151c94d60f4c0b04439c",
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
