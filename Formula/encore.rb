class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.13.2"
    checksums = {
        "darwin_arm64" => "2fdb7e08c7a07ef30fab3ce072b3bc6d97d437893ab4acba55834f6577857374",
        "darwin_amd64" => "475d2ab607a932f911f36983128550965e04e023a7547c6fbf25d6558988f1fd",
        "linux_arm64"  => "927b4dae3d0bd1bb26b625ac2cae06f2808760fee18086059dc5acc605729a6b",
        "linux_amd64"  => "96a6c4d53132e8fd92216ff58d0140dcab40e00ec13dc33d5fa2f2d314f38d69",
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
