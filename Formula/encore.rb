class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.3"
    checksums = {
        "darwin_arm64" => "3412586417d0f02df3346a631836ec04c5f19034655bf67b442884c6ec116933",
        "darwin_amd64" => "bbfb55c1b3988454fdf4def0908669ef00976420496f8e8c6737e9b95881ceec",
        "linux_arm64"  => "2b1337d9f7d8d1cd10c01f432b63dddaa4dfc2844a8cca8be13736f7919eaecd",
        "linux_amd64"  => "28f4321726d756e3820e2d04af1d99e792d43c2bab2a179f2884a2f97191741f",
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
