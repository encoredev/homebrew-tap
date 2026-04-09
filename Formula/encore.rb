class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.56.5"
    checksums = {
        "darwin_arm64" => "41378987f811e5a9a363aef4954e184c4adf57d7e2a300319d2debb978f4972c",
        "darwin_amd64" => "0f6817a5163c0c31dd54ea553c3dcb43b9b833ba511a6c807fbab09831c5bbb3",
        "linux_arm64"  => "ca576cfe434c18b4c99937ff9df4e244a7a0e5009eba2ddd01e69be35379b416",
        "linux_amd64"  => "2f3ec6b50e7f79339294c9c08f2ab0ab03af99404ac606640896bf7cf8ae0fe2",
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
